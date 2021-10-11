import { paramCase } from 'param-case';
import {
  assoc,
  clone,
  map,
  pipe,
  prop,
// @ts-ignore
} from 'ramda';
import * as React from 'react';
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
} from '../../store/activityFilterSlice';
import { ActivityFilterT } from '../../store/activityFilterSliceTypes';
import { UserActivityColumnsEnum } from '../../store/userActivitySliceTypes';

const animatedComponents = makeAnimated();
const { useEffect, useState } = React;

export interface OptionsT {
  readonly value: string;
  readonly label: string;
}

const createOption = (label: string): OptionsT => ({
  label,
  value: paramCase(label),
});

export type FilterListProps = {
  canHide: boolean;
  columnName: keyof ActivityFilterT;
  setVisibility: React.Dispatch<React.SetStateAction<string>>;
  style: { [key: string]: string };
};

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
  }, [activeFilter]);

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
    <Container className="filter-list" style={style}>
      <Row>
        <Col className="filter-list-label" md={2}>
          {UserActivityColumnsEnum[columnName]}
          :
        </Col>
        <Col md={9}>
          <Select
            className="filter-list-dropdown"
            closeMenuOnSelect={false}
            components={animatedComponents}
            isMulti
            noOptionsMessage={() => 'Nincs több találat'}
            onChange={handleChange}
            options={options}
            placeholder="Keresés..."
            value={activeOptions}
          />
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

export default FilterList;
