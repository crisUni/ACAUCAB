import React, { useState, useEffect } from 'react';

const OptionInput = ({ endpoint, index, onAmountChange }) => {
  const [options, setOptions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [amount, setAmount] = useState('');

  useEffect(() => {
    const fetchOptions = async () => {
      try {
        const response = await fetch(endpoint);
        const data = await response.json();
        setOptions(data);
      } catch (error) {
        console.error('Error fetching options:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchOptions();
  }, [endpoint]);

  const handleAmountChange = (e) => {
    const value = e.target.value;
    setAmount(value);
    onAmountChange(index, value); // Notify parent component of the amount change
  };

  if (loading) {
    return <p>Loading options...</p>;
  }

  return (
    <div style={{ marginBottom: '10px' }}>
      <select>
        {options.map((option) => (
          <option key={option.eid} value={option.eid}>
            {option.displayName}
          </option>
        ))}
      </select>
      <input
        type="number"
        value={amount}
        onChange={handleAmountChange}
        placeholder="Amount"
        style={{ marginLeft: '10px' }}
      />
    </div>
  );
};

const DynamicOptionInputs = ({ eidKey = 'eid', endpoint }) => {
  const [inputs, setInputs] = useState([]);
  const [amounts, setAmounts] = useState({});

  const addInput = () => {
    setInputs([...inputs, inputs.length]);
  };

  const handleAmountChange = (index, value) => {
    setAmounts((prevAmounts) => ({
      ...prevAmounts,
      [index]: value,
    }));
  };

  const getValues = () => {
    const result = inputs.map((_, index) => ({
      [eidKey]: document.querySelectorAll('select')[index].value,
      amount: amounts[index] || 0, // Default to 0 if no amount is provided
    }));
    console.log(result); // You can handle the result as needed
    return result; // Return the result if needed
  };

  // You can call getValues() from a parent component or another event as needed

  return (
    <div>
      {inputs.map((_, index) => (
        <OptionInput
          key={index}
          index={index}
          endpoint={endpoint} // Pass the endpoint prop to OptionInput
          onAmountChange={handleAmountChange}
        />
      ))}
      <button type="button" onClick={addInput}>Add Option Input</button>
    </div>
  );
};

export default DynamicOptionInputs;
