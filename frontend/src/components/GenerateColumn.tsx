import React, { useState } from 'react';

type ColumnDisplay = {
    title: string,
    keyName: string
}

type ColumnAction = {
    title: string,
    action: (data: { [key: string]: string }) => void
}

function GenerateColumn(columns: ColumnDisplay[], data: { [key: string]: string }[], actions: ColumnAction[] = [], itemsPerPage: number = 5) {
    const [currentPage, setCurrentPage] = useState(1);

    // Calculate total pages
    const totalPages = Math.ceil(data.length / itemsPerPage);

    // Get the current data slice
    const startIndex = (currentPage - 1) * itemsPerPage;
    const currentData = data.slice(startIndex, startIndex + itemsPerPage);

    const handleNextPage = () => {
        if (currentPage < totalPages) {
            setCurrentPage(currentPage + 1);
        }
    };

    const handlePreviousPage = () => {
        if (currentPage > 1) {
            setCurrentPage(currentPage - 1);
        }
    };

    return (
        <div>
            <table>
                <thead>
                    <tr>
                        {actions.map((x, index) => <th key={index}>{x.title}</th>)}
                        {columns.map((x, index) => <th key={index}>{x.title}</th>)}
                    </tr>
                </thead>
                <tbody>
                    {
                        currentData.map((da, rowIndex) =>
                            <tr key={rowIndex}>
                                {actions.map((x, actionIndex) => (
                                    <td key={actionIndex}>
                                        <button onClick={() => x.action(da)}>{x.title}</button>
                                    </td>
                                ))}
                                {columns.map((x, colIndex) => <td key={colIndex}>{da[x.keyName]}</td>)}
                            </tr>
                        )
                    }
                </tbody>
            </table>
            <div>
                <button onClick={handlePreviousPage} disabled={currentPage === 1}>Previous</button>
                <span> Page {currentPage} of {totalPages} </span>
                <button onClick={handleNextPage} disabled={currentPage === totalPages}>Next</button>
            </div>
        </div>
    );
}

export default GenerateColumn;
