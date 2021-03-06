import {
  assoc,
  clone,
  map,
  pipe,
  prop,
// @ts-ignore
} from 'ramda';
import { useEffect, useState } from 'react';
import {
  Button,
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import {
  fetchColumnOptions,
  filterModified,
  selectActiveFilter,
} from '../../store/activityFilter/activityFilterSlice';
import { OptionsT } from '../../interfaces/common';
import { FilterListProps } from '../../interfaces/useractivity';
import { UserActivityColumnsEnum } from '../../store/userActivity/userActivitySliceTypes';
import { createOption } from '../utils/helpers';

import './filter-list.scss';

const animatedComponents = makeAnimated();

const FilterList = ({
  canHide,
  columnName,
  setVisibility,
  style,
}: FilterListProps) => {
  const dispatch = useAppDispatch();
  const activeFilter = useAppSelector(selectActiveFilter);
  const [activeOptions, setActiveOptions] = useState<OptionsT[]>([]);
  const [options, setOptions] = useState<OptionsT[]>([]);

  useEffect(() => {
    fetchColumnOptions(columnName)
      .then((fetchedOptions) => {
        setOptions(map(createOption, fetchedOptions));
      });
  }, [columnName]);

  useEffect(() => {
    setActiveOptions(map(createOption, prop(columnName, activeFilter)));
  }, [activeFilter, columnName]);

  const handleChange = (selectedOptions: OptionsT[]) => {
    const selectedOptionsArray: string[] = map(prop('label'), selectedOptions);
    dispatch(filterModified(
      pipe(
        clone,
        assoc(columnName, selectedOptionsArray),
      )(activeFilter),
    ));
  };

  return (
    <Container fluid className="filter-list" style={style}>
      <Row>
        <Col className="filter-list-label" md={2}>
          {UserActivityColumnsEnum[columnName]}
          :
        </Col>
        <Col md={8}>
          <Select
            closeMenuOnSelect={false}
            components={animatedComponents}
            isMulti
            noOptionsMessage={() => 'Nincs t??bb tal??lat'}
            onChange={handleChange}
            options={options}
            placeholder="Keres??s..."
            value={activeOptions}
          />
        </Col>
        <Col md={2} className="filter-list-button">
          {canHide && (
            <Button
              className="float-right"
              variant="primary"
              onClick={() => setVisibility('none')}
              size="sm"
            >
              Elrejt
            </Button>
          )}
        </Col>
      </Row>
    </Container>
  );
};

export default FilterList;
