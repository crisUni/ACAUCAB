type ColumnDisplay = {
    title: string,
    keyName: string
}

type ColumnAction = {
    title: string,
    action: (data: { [key: string]: string }) => void
}

function GenerateColumn(columns: ColumnDisplay[], data: { [key: string]: string }[], actions: ColumnAction[] = []) {
    return (
        <table>
            <thead>
                <tr>
                    {actions.map((x) => <th>{x.title}</th>)}
                    {columns.map((x) => <th>{x.title}</th>)}
                </tr>
            </thead>
            <tbody>
                {
                    data.map(da =>
                        <tr>
                            {actions.map((x) => <td><button onClick={_ => x.action(da)}>{x.title}</button></td>)}
                            {columns.map((x) => <td>{da[x.keyName]}</td>)}
                        </tr>
                    )
                }
            </tbody>
        </table>
    )
}

export default GenerateColumn;
