type ColumnDisplay = {
    title: string,
    keyName: string
}

function GenerateColumn(columns: ColumnDisplay[], data: { [key: string]: string }[]) {
    return (
        <table>
            <tr>
                {columns.map((x) => <th>{x.title}</th>)}
            </tr>
            {
                data.map(da =>
                    <tr>
                        {columns.map((x) => <td>{da[x.keyName]}</td>)}
                    </tr>
                )
            }
        </table>
    )
}

export default GenerateColumn;
