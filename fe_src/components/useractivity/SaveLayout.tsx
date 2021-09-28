import * as React from 'react';
import { Button, FormControl, InputGroup } from 'react-bootstrap';

const SaveLayout = () => (
  <InputGroup className="mb-3 filter-list">
    <FormControl
      placeholder="Nézet mentése..."
      aria-label="Nézet mentése..."
      aria-describedby="basic-save-layout"
    />
    <Button variant="outline-primary" id="button-save-layout">
      Mentés
    </Button>
  </InputGroup>
);

export default SaveLayout;
