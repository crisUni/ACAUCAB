import { HTMLInputTypeAttribute, JSX, useEffect, useState } from "react"
import DynamicOptionInputs from "./DynamicOptions"
import { goto } from "./SmartLink"
import { useNavigate } from "react-router-dom"

type EntryBase = {
    label: string
}

type PresetValue = EntryBase & {
    keyName: string,
    value: any,
}

type DerivedValue = EntryBase & {
    value_1: string,
    value_2: string,
    action: "multiply"
}

type DynamicOptions = EntryBase & {
    keyName: string, // fk_cerveza,fk_presentacion,fk_tienda
    required: boolean,
    fetchFrom: string,
    multiple: boolean
}

type FormEntry<T> = EntryBase & {
    keyName: string,
    required: boolean,
    inputType: HTMLInputTypeAttribute
}

type FormEntrySelectFromDatabase = EntryBase & {
    keyName: string, // fk_cerveza,fk_presentacion,fk_tienda
    required: boolean,
    fetchFrom: string,
}

type FormOptions = {
    url?: string
    method?: "POST" | "DELETE"
    callback?: (data: any) => void
    fetchCallback?: (data: any) => void
    redirect?: string
    redirect_var?: string
}

function GenerateForm(entries: (FormEntry<unknown> | FormEntrySelectFromDatabase | DynamicOptions | PresetValue | DerivedValue)[], options: FormOptions) {
    const navigate = useNavigate();
    const [fromDatabase, setFromDatabase] = useState<{ [key: string | symbol]: any }>({});
    const [formData, setFormData] = useState<{ [key: string | symbol]: any }>(() => {
        const res: { [key: string | symbol]: any } = {};
        for (const entry of entries.filter(x => 'keyName' in x))
            res[entry.keyName] = ''

        const fetchResponses: { [key: string | symbol]: any } = {}

        for (const entry of entries.filter(x => 'value' in x))
            res[entry.keyName] = entry.value

        for (const entry of entries.filter(x => 'fetchFrom' in x))
            fetchResponses[entry.keyName] = fetch(entry.fetchFrom)
                .then(async res => await res.json())
                .catch(err => { console.error("Check the logs!!", err); return []; })

        Promise.all(Object.values(fetchResponses))
            .then(async res => {
                const keys = Object.keys(fetchResponses);
                const resultObject: any = {};
                res.forEach((v, i) => { resultObject[keys[i]] = v; });
                setFromDatabase(resultObject)
            })
        return res;
    });

    const handleChange = (e: any) => {
        const { name, value }: { name: string, value: string | string[] } = e.target;
        setFormData({ ...formData, [name]: value, });
    };

    function generateHTML(entry: FormEntry<unknown> | FormEntrySelectFromDatabase | DerivedValue | DynamicOptions): JSX.Element {
        if ('action' in entry)
            return generateDerivedHTML(entry)
        if ('value' in entry)
            return generateStaticValueHTML(entry)
        if ('multiple' in entry)
            return (<DynamicOptionInputs label={entry.label} endpoint={entry.fetchFrom} onChange={(d: string) => handleChange({ target: { name: String(entry.keyName), value: d } })} />)
        if ('fetchFrom' in entry)
            return generateSelectHTML(entry);
        if ('inputType' in entry)
            return generateInputHTML(entry);
        return <></>
    }

    function generateDerivedHTML(entry: DerivedValue) {
        return (
            <div>
                <label> {entry.label} </label>
                <b>
                    {Number(formData[entry.value_1]) * Number(formData[entry.value_2])}
                </b>
            </div>
        )
    }

    function generateStaticValueHTML(entry: PresetValue): JSX.Element {
        return (
            <div>
                <label>
                    {entry.label}:
                    <input
                        type="text"
                        disabled={true}
                        name={entry.keyName}
                        value={entry.value}
                        onChange={handleChange}
                        required
                    />
                </label>
            </div>
        )
    }

    function generateInputHTML(entry: FormEntry<unknown>): JSX.Element {
        return (
            <div>
                <label>
                    {entry.label}:
                    <input
                        type={entry.inputType}
                        name={entry.keyName}
                        value={formData[entry.keyName]}
                        onChange={handleChange}
                        required
                    />
                </label>
            </div>
        )
    }

    function generateSelectHTML(entry: FormEntrySelectFromDatabase): JSX.Element {
        return (<div>
            <label>
                {entry.label}
                <select name={entry.keyName} value={formData[entry.keyName]} onChange={handleChange} required>
                    <option value="" disabled>Select an option</option>
                    {entry.keyName in fromDatabase && fromDatabase[entry.keyName].map((n: any) => (
                        <option key={n.eid} value={n.eid}>
                            {n.displayName ?? "?"}
                        </option>
                    ))}
                </select>
            </label>
        </div>)
    }

    function postToUrl(data: any) {
        return fetch(options.url as string, {
            method: options.method === undefined ? "POST" : options.method,
            body: data
        })
            .then(async res => {
                const data = await res.json();
                if (options.fetchCallback) options.fetchCallback(data);
            })
            .catch(err => console.error)
    }

    const handleSubmit = async (e: any) => {
        e.preventDefault();

        let newFormData: { [key: string]: any } = formData;
        for (const key in formData) {
            const split_key = (key + '').split(',');
            if (split_key.length < 2) continue;
            if (Array.isArray(formData[key])) {
                for (const data of formData[key]) {
                    const split_values: string[] = data.split(',')
                    for (const i in split_values)
                        newFormData = { ...newFormData, [split_key[i]]: [...(newFormData[split_key[i]] || []), split_values[i]] }
                    delete newFormData[key]
                }
            } else {
                const split_values: string[] = formData[key].split(',')
                for (const i in split_values)
                    newFormData = { ...newFormData, [split_key[i]]: split_values[i] }
                delete newFormData[key]
            }

        }

        for (const key in newFormData)
            if (((newFormData[key] ?? undefined) === undefined) || newFormData[key] === "null")
                delete newFormData[key]

        const data = JSON.stringify({ insert_data: newFormData });
        if ('url' in options && options.url !== undefined)
            await postToUrl(data)
        if ('callback' in options && options.callback !== undefined)
            options.callback(JSON.parse(data))
        if ('redirect' in options && options.redirect) {
            const url = options.redirect + (newFormData[options.redirect_var || ''] || '')
            navigate(url)
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            {
                entries.map((x: any) => generateHTML(x))
            }
            <button type="submit">Submit</button>
        </form>
    )
}

export default GenerateForm;