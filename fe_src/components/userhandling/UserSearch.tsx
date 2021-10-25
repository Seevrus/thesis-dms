import * as React from 'react';
import {
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

const animatedComponents = makeAnimated();

const UserSearch = () => (
  <Container className="filter-list" style={style}>
    <Row>
      <Col md={9}>
        <Select
          className="filter-list-dropdown"
          closeMenuOnSelect={false}
          components={animatedComponents}
          isMulti
          noOptionsMessage={() => 'Nincs több találat'}
          onChange={handleChange}
          options={options}
          placeholder="Felhasználó keresése..."
          value={activeOptions}
        />
      </Col>
    </Row>
  </Container>
);

export default UserSearch;
