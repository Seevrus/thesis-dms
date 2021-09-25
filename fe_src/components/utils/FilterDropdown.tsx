import {
  assoc,
  clone,
  map,
  pipe,
  prop,
// @ts-ignore
} from 'ramda';
import * as React from 'react';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';
import { UserActivityRequestT } from '../../store/userActivitySliceTypes';

const animatedComponents = makeAnimated();

export interface OptionsT {
  readonly value: string;
  readonly label: string;
}

type FilterDropdownPropsT = {
  className: string;
  filterKey: keyof UserActivityRequestT;
  filterState: UserActivityRequestT;
  options: OptionsT[];
  setFilterState: React.Dispatch<React.SetStateAction<UserActivityRequestT>>;
};

const FilterDropdown = ({
  className,
  filterKey,
  filterState,
  options,
  setFilterState,
}: FilterDropdownPropsT) => {
  const handleChange = (selectedOptions: OptionsT[]) => {
    const selectedOptionsArray: string[] = map(prop('label'), selectedOptions);
    setFilterState(
      pipe(
        clone,
        assoc(filterKey, selectedOptionsArray),
      )(filterState),
    );
  };

  return (
    <Select
      closeMenuOnSelect={false}
      components={animatedComponents}
      isMulti
      className={className}
      options={options}
      placeholder="Keresés..."
      noOptionsMessage={() => 'Nincs több találat'}
      onChange={handleChange}
    />
  );
};

export default FilterDropdown;
