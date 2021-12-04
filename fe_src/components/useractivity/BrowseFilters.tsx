import { paramCase } from 'param-case';
// @ts-ignore
import { find, propEq } from 'ramda';
import { useEffect, useState } from 'react';
import {
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { OptionsT } from '../../interfaces/common';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { SavedFilterT } from '../../store/activityFilter/activityFilterSliceTypes';
import {
  filterCleared,
  filterModified,
  getMatchingSavedFilter,
  getSavedFilters,
} from '../../store/activityFilter/activityFilterSlice';

const animatedComponents = makeAnimated();

const createFilterOption = (filter: SavedFilterT): OptionsT => {
  if (filter) {
    return {
      label: filter.filterName,
      value: paramCase(filter.filterName),
    };
  }
  return null;
};

const BrowseFilters = () => {
  const dispatch = useAppDispatch();

  const matchingSavedFilter = useAppSelector(getMatchingSavedFilter);
  const savedFilters = useAppSelector(getSavedFilters);

  const [optionsState, setOptionsState] = useState<OptionsT[]>([]);
  const [defaultOption, setDefaultOption] = useState<OptionsT>();

  useEffect(() => {
    setOptionsState(
      savedFilters.map(createFilterOption),
    );
  }, [savedFilters]);

  useEffect(() => {
    setDefaultOption(createFilterOption(matchingSavedFilter));
  }, [matchingSavedFilter]);

  const handleChange = (selectedOption: OptionsT) => {
    if (!selectedOption) {
      dispatch(filterCleared());
    } else {
      const selectedSavedFilter: SavedFilterT = find(
        propEq('filterName', selectedOption.label),
        savedFilters,
      );
      dispatch(filterModified(selectedSavedFilter.activityFilter));
    }
  };

  return (
    <Container fluid className="filter-list">
      <Row>
        <Col md={2} className="filter-list-label">
          Mentett szűrők:
        </Col>
        <Col md={8}>
          <Select
            closeMenuOnSelect={false}
            components={animatedComponents}
            isClearable
            noOptionsMessage={() => 'Nincs több találat'}
            onChange={handleChange}
            options={optionsState}
            placeholder="Keresés..."
            value={defaultOption}
          />
        </Col>
        <Col md={2} />
      </Row>
    </Container>
  );
};

export default BrowseFilters;
