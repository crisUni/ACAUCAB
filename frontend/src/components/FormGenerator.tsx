import { HTMLInputTypeAttribute, JSX, useState } from "react"
import DynamicOptionInputs from "./DynamicOptions"

type DynamicOptions = {
    label: string,
    keyName: string, // fk_cerveza,fk_presentacion,fk_tienda
    required: boolean,
    fetchFrom: string,
    multiple: boolean
}

type FormEntry<T> = {
    label: string,
    keyName: string,
    required: boolean,
    inputType: HTMLInputTypeAttribute
}

type FormEntrySelectFromDatabase = {
    label: string,
    keyName: string, // fk_cerveza,fk_presentacion,fk_tienda
    required: boolean,
    fetchFrom: string,
}

type FormOptions = {
    url?: string,
    callback?: (data: any) => void;
    method?: "POST" | "DELETE"
}

function GenerateForm(entries: (FormEntry<unknown> | FormEntrySelectFromDatabase | DynamicOptions)[], options: FormOptions) {
    const [fromDatabase, setFromDatabase] = useState<{ [key: string | symbol]: any }>({});
    const [formData, setFormData] = useState<{ [key: string | symbol]: any }>(() => {
        const res: { [key: string | symbol]: any } = {};
        for (const entry of entries)
            res[entry.keyName] = ''

        const fetchResponses: { [key: string | symbol]: any } = {}

        for (const entry of entries.filter(x => 'fetchFrom' in x))
            fetchResponses[entry.keyName] = fetch(entry.fetchFrom)
                .then(async res => await res.json())
                .catch(err => { console.log("Check the logs!!", err); return []; })

        Promise.all(Object.values(fetchResponses))
            .then(async res => {
                const keys = Object.keys(fetchResponses);
                const resultObject: any = {};
                res.forEach((v, i) => { resultObject[keys[i]] = v; });
                setFromDatabase(resultObject)
            })
        return res;
    });

    const handleCatalogChange = (e: any) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value, });
    };

    const handleChange = (e: any) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value, });
    };

    function generateHTML(entry: FormEntry<unknown> | FormEntrySelectFromDatabase): JSX.Element {
        if ('multiple' in entry)
            return (<DynamicOptionInputs eidKey={entry.keyName} endpoint={entry.fetchFrom}/>)
        if ('fetchFrom' in entry)
            return generateSelectHTML(entry as FormEntrySelectFromDatabase);
        if ('inputType' in entry)
            return generateInputHTML(entry as FormEntry<unknown>);
        return <></>
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
            .then(async res => console.log(await res.json()))
            .catch(err => console.error)
    }

    const handleSubmit = async (e: any) => {
        e.preventDefault();

        let newFormData = formData;
        for (const key in formData) {
            const split_key = key.split(',');
            if (split_key.length < 2) continue;
            const split_values: string[] = formData[key].split(',')
            for (const i in split_values)
                newFormData = { ...newFormData, [split_key[i]]: split_values[i] }
            delete newFormData[key]
        }

        for (const key in newFormData)
            if (((newFormData[key] ?? undefined) === undefined) || newFormData[key] === "null")
                delete newFormData[key]

        const data = JSON.stringify({ insert_data: newFormData });
        if ('url' in options && options.url !== undefined)
            await postToUrl(data)
        if ('callback' in options && options.callback !== undefined)
            options.callback(JSON.parse(data))
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