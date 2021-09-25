import { paramCase } from 'param-case';
import * as React from 'react';
import {
  Button,
} from 'react-bootstrap';
import { UserActivityColumnsEnum, UserActivityRequestT } from '../../store/userActivitySliceTypes';
import { fetchColumnOptions } from '../../store/userActivitySlice';

import FilterDropdown, { OptionsT } from '../utils/FilterDropdown';

const { useEffect, useState } = React;

type FilterListProps = {
  canHide: boolean;
  columnName: keyof UserActivityRequestT;
  filterState: UserActivityRequestT;
  setFilterState: React.Dispatch<React.SetStateAction<UserActivityRequestT>>;
  setVisibility: React.Dispatch<React.SetStateAction<string>>;
  style: { [key: string]: string };
};

const FilterList = ({
  canHide,
  columnName,
  filterState,
  setFilterState,
  setVisibility,
  style,
}: FilterListProps) => {
  const [optionsState, setOptionsState] = useState<OptionsT[]>([]);

  useEffect(() => {
    fetchColumnOptions(columnName)
      .then((options) => {
        setOptionsState(
          options.map((option) => ({
            label: option,
            value: paramCase(option),
          })),
        );
      });
  }, [columnName]);

  return (
    <div className="filter-list" style={style}>
      <span>
        {UserActivityColumnsEnum[columnName]}
        :
      </span>
      <FilterDropdown
        className="filter-list-dropdown"
        filterKey={columnName}
        filterState={filterState}
        options={optionsState}
        setFilterState={setFilterState}
      />
      <div className="filter-btn-container">
        {canHide && (
        <Button variant="outline-primary" onClick={() => setVisibility('none')} size="sm">
          Elrejt
        </Button>
        )}
      </div>
    </div>
  );
};

export default FilterList;
