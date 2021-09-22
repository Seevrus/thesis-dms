import * as React from 'react';
import {
  Button,
  Form,
} from 'react-bootstrap';

const { useState } = React;

export type FilterType = {
  checked: boolean;
  id: string;
  label: string;
}[];

type FilterListProps = {
  options: FilterType;
  setVisibility: React.Dispatch<React.SetStateAction<string>>;
  style: { [key: string]: string };
};

const FilterList = ({ options, setVisibility, style }: FilterListProps) => {
  const [optionsState, setOptionsState] = useState(options);

  const handleChange = (id: string) => {
    const newOptions = optionsState.map((option) => {
      if (option.id === id) {
        return {
          ...option,
          checked: !option.checked,
        };
      }
      return option;
    });
    setOptionsState(newOptions);
  };

  const resetFilters = (e: React.MouseEvent) => {
    e.stopPropagation();
    const newOptions = optionsState.map((option) => ({
      ...option,
      checked: true,
    }));
    setOptionsState(newOptions);
    setVisibility('none');
  };

  return (
    <div className="filter-list" style={style}>
      {optionsState.map(({ checked, id, label }) => (
        <Form.Check
          type="checkbox"
          checked={checked}
          id={id}
          key={id}
          label={label}
          onChange={() => handleChange(id)}
        />
      ))}
      <div className="filter-btn-container">
        <Button variant="outline-primary" size="sm">
          Alkalmaz
        </Button>
        <Button variant="outline-primary" onClick={resetFilters} size="sm">
          Visszaállít
        </Button>
      </div>
    </div>
  );
};

export default FilterList;
