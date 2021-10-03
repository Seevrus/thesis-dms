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

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { filterModified, selectActiveFilter } from '../../store/activityFilterSlice';
import { ActivityFilterT } from '../../store/activityFilterSliceTypes';

const animatedComponents = makeAnimated();

export interface OptionsT {
  readonly value: string;
  readonly label: string;
}

type FilterDropdownPropsT = {
  className: string;
  filterKey: keyof ActivityFilterT;
  options: OptionsT[];
};

const FilterDropdown = ({
  className,
  filterKey,
  options,
}: FilterDropdownPropsT) => {
  const dispatch = useAppDispatch();
  const activeFilter = useAppSelector(selectActiveFilter);

  const handleChange = (selectedOptions: OptionsT[]) => {
    const selectedOptionsArray: string[] = map(prop('label'), selectedOptions);
    dispatch(filterModified(
      pipe(
        clone,
        assoc(filterKey, selectedOptionsArray),
      )(activeFilter),
    ));
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
