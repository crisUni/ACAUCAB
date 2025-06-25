import React, { useState, useEffect } from 'react';

const OptionInput = ({ index, onAmountChange, onOptionChange, allSelectedOptions, options }) => {
  const [amount, setAmount] = useState('');
  const [selectedOption, setSelectedOption] = useState('');

  const handleAmountChange = (e) => {
    const value = e.target.value;
    setAmount(value);
    onAmountChange(index, value);
  };

  const handleOptionChange = (e) => {
    const value = e.target.value;
    setSelectedOption(value);
    onOptionChange(index, value);
  };

  return (
    <div style={{ marginBottom: '10px' }}>
      <select value={selectedOption} onChange={handleOptionChange}>
        <option value="" disabled>
          Seleccionar una opción
        </option>
        {options.map((option) => (
          <option key={option.eid} value={option.eid} disabled={allSelectedOptions.has(option.eid) && selectedOption !== option.eid}>
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

const DynamicOptionInputs = ({ label, endpoint, onChange }: { label: string, endpoint: string, onChange: (data: any) => void}) => {
  const [inputs, setInputs] = useState([]);
  const [amounts, setAmounts] = useState({});
  const [selectedOptions, setSelectedOptions] = useState({});
  const [allSelectedOptions, setAllSelectedOptions] = useState(new Set());
  const [options, setOptions] = useState([]);
  const [loading, setLoading] = useState(true);

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

  const addInput = () => {
    setInputs([...inputs, inputs.length]);
  };

  const notifyChange = (index, optionValue, amountValue) => {
    const valuesArray = inputs.map((_, idx) => {
      const eid = (idx === index ? optionValue : null) || selectedOptions[idx] || '';
      const amount = (idx === index ? amountValue : null) || amounts[idx] || 0;
      return `${eid},${amount}`;
    });
    if (onChange) {
      onChange(valuesArray);
    }
  };

  const handleAmountChange = (index, value) => {
    setAmounts((prevAmounts) => ({ ...prevAmounts, [index]: value }));
    notifyChange(index, selectedOptions[index], value);
  };

  const handleOptionChange = (index, value) => {
    setAllSelectedOptions((prev) => {
      const newSet = new Set(prev);
      if (value) newSet.add(value);
      return newSet;
    });

    setSelectedOptions((prevOptions) => ({ ...prevOptions, [index]: value }));
    notifyChange(index, value, amounts[index]);
  };

  const clearAllInputs = () => {
    setInputs([]);
    setAmounts({});
    setSelectedOptions({});
    setAllSelectedOptions(new Set());
    notifyChange(-1, '', 0);
  };

  if (loading) {
    return <p>Loading options...</p>;
  }

  return (
    <div>
      <label> {label} </label>
      {inputs.map((_, index) => (
        <OptionInput
          key={index}
          index={index}
          onAmountChange={handleAmountChange}
          onOptionChange={handleOptionChange}
          allSelectedOptions={allSelectedOptions}
          options={options}
        />
      ))}
      <button type="button" onClick={addInput} disabled={inputs.length >= options.length}>
        Add Option Input
      </button>
      <button type="button" onClick={clearAllInputs} style={{ marginLeft: '10px' }}>
        Clear All
      </button>
    </div>
  );
};

export default DynamicOptionInputs;
