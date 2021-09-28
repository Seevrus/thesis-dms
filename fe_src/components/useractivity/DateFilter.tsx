import { format } from 'date-fns';
import {
  assocPath,
  clone,
  contains,
  dissocPath,
  path,
  pipe,
// @ts-ignore
} from 'ramda';
import * as React from 'react';
import {
  Button,
  Col,
  Container,
  Form,
  Row,
} from 'react-bootstrap';
import DatePicker from 'react-date-picker';
import { UserActivityColumnsEnum } from '../../store/userActivitySliceTypes';
import { FilterListProps } from './FilterList';

const { useState } = React;

const CheckboxLabelE = {
  validUntil: 'Korlátlan',
  downloaded: 'Még nem töltötte le',
};

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

  const handleCheckboxChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFilterState(
      pipe(
        clone,
        assocPath([e.target.id, 'checked'], e.target.checked),
      ),
    );
  };

  const handleDateChange = (newDate: Date, side: 'from' | 'to') => {
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
    <Container className="filter-list" style={style}>
      <Row>
        <Col className="filter-list-label" md={2}>
          {UserActivityColumnsEnum[columnName]}
          :
        </Col>
        <Col md={3}>
          <DatePicker
            onChange={(newDate: Date) => handleDateChange(newDate, 'from')}
            value={valueFrom}
          />
        </Col>
        <Col md={3}>
          <DatePicker
            onChange={(newDate: Date) => handleDateChange(newDate, 'to')}
            value={valueTo}
          />
        </Col>
        <Col md={3}>
          {contains(columnName, ['validUntil', 'downloaded']) && (
          <Form.Check
            inline
            id={columnName}
            checked={path([columnName, 'checked'], filterState)}
            // @ts-ignore
            label={CheckboxLabelE[columnName]}
            name="group1"
            type="checkbox"
            onChange={handleCheckboxChange}
          />
          )}
        </Col>
        <Col md={1}>
          {canHide && (
          <Button variant="outline-primary" onClick={() => setVisibility('none')} size="sm">
            Elrejt
          </Button>
          )}
        </Col>
      </Row>
    </Container>
  );
};

export default DateFilter;
