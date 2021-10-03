import { paramCase } from 'param-case';
// @ts-ignore
import { find, propEq } from 'ramda';
import * as React from 'react';
import {
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { SavedFilterT } from '../../store/activityFilterSliceTypes';
import { filterModified, getSavedFilters } from '../../store/activityFilterSlice';

import { OptionsT } from './FilterDropdown';

const { useEffect, useState } = React;
const animatedComponents = makeAnimated();

const BrowseFilters = () => {
  const dispatch = useAppDispatch();
  const [optionsState, setOptionsState] = useState<OptionsT[]>([]);
  const savedFilters = useAppSelector(getSavedFilters);

  useEffect(() => {
    setOptionsState(
      savedFilters.map((savedFilter) => ({
        label: savedFilter.filterName,
        value: paramCase(savedFilter.filterName),
      })),
    );
  }, [savedFilters]);

  const handleChange = (selectedOption: OptionsT) => {
    const selectedSavedFilter: SavedFilterT = find(
      propEq('filterName', selectedOption.label),
      savedFilters,
    );
    dispatch(filterModified(selectedSavedFilter.activityFilter));
  };

  return (
    <Container className="filter-list">
      <Row>
        <Col className="filter-list-label" md={2}>
          Mentett szűrők:
        </Col>
        <Col md={9}>
          <Select
            closeMenuOnSelect={false}
            components={animatedComponents}
            className="filter-list-dropdown"
            options={optionsState}
            placeholder="Keresés..."
            noOptionsMessage={() => 'Nincs több találat'}
            onChange={handleChange}
          />
        </Col>
        <Col md={1} />
      </Row>
    </Container>
  );
};

export default BrowseFilters;
