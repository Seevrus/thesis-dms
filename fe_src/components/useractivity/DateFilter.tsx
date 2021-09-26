import { format } from 'date-fns';
import {
  assocPath,
  clone,
  dissocPath,
  pipe,
// @ts-ignore
} from 'ramda';
import * as React from 'react';
import { Button } from 'react-bootstrap';
import DatePicker from 'react-date-picker';
import { UserActivityColumnsEnum } from '../../store/userActivitySliceTypes';
import { FilterListProps } from './FilterList';

const { useState } = React;

const DateFilter = ({
  canHide,
  columnName,
  filterState,
  setFilterState,
  setVisibility,
  style,
}: FilterListProps) => {
  const [valueFrom, setValueFrom] = useState<Date>(null);
  const [valueTo, setValueTo] = useState<Date>(null);

  console.log(filterState.added);

  const handleChange = (newDate: Date, side: 'from' | 'to') => {
    // eslint-disable-next-line @typescript-eslint/no-unused-expressions
    side === 'from' ? setValueFrom(newDate) : setValueTo(newDate);
    if (newDate) {
      const formattedDate = newDate && format(newDate, 'yyyy-MM-dd');
      setFilterState(
        pipe(
          clone,
          assocPath([columnName, side], formattedDate),
        )(filterState),
      );
    } else {
      setFilterState(
        pipe(
          clone,
          dissocPath([columnName, side]),
        )(filterState),
      );
    }
  };

  return (
    <div className="filter-list" style={style}>
      <span>
        {UserActivityColumnsEnum[columnName]}
        :
      </span>
      <DatePicker
        onChange={(newDate: Date) => handleChange(newDate, 'from')}
        value={valueFrom}
      />
      <DatePicker
        onChange={(newDate: Date) => handleChange(newDate, 'to')}
        value={valueTo}
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

export default DateFilter;
