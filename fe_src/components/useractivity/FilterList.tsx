import { paramCase } from 'param-case';
import * as React from 'react';
import {
  Button,
  Col,
  Container,
  Row,
} from 'react-bootstrap';

import { fetchColumnOptions } from '../../store/activityFilterSlice';
import { ActivityFilterT } from '../../store/activityFilterSliceTypes';
import { UserActivityColumnsEnum } from '../../store/userActivitySliceTypes';

import FilterDropdown, { OptionsT } from './FilterDropdown';

const { useEffect, useState } = React;

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
    <Container className="filter-list" style={style}>
      <Row>
        <Col className="filter-list-label" md={2}>
          {UserActivityColumnsEnum[columnName]}
          :
        </Col>
        <Col md={9}>
          <FilterDropdown
            className="filter-list-dropdown"
            filterKey={columnName}
            options={optionsState}
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
