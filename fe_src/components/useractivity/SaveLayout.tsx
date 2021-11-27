import { useState } from 'react';
import {
  Button,
  Col,
  Container,
  Form,
  Row,
} from 'react-bootstrap';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { getMatchingSavedFilter, saveFilter, selectActiveFilter } from '../../store/activityFilterSlice';

import './filter-list.scss';

const SaveLayout = () => {
  const dispatch = useAppDispatch();

  const [filterName, setFilterName] = useState('');
  const [formInvalid, setFormInvalid] = useState(false);

  const activeFilter = useAppSelector(selectActiveFilter);
  const matchingSavedFilter = useAppSelector(getMatchingSavedFilter);

  const handleClick = () => {
    if (!filterName) {
      setFormInvalid(true);
    } else {
      setFormInvalid(false);
      dispatch(saveFilter({ filterName, filter: activeFilter }));
    }
  };

  return (
    <Container fluid className="filter-list">
      <Row>
        <Col className="filter-list-label" md={2}>
          Nézet mentése:
        </Col>
        <Col md={8}>
          <Form.Group className="mb-3">
            <Form.Control
              aria-describedby="basic-save-layout"
              onChange={(e: React.ChangeEvent<HTMLInputElement>) => setFilterName(e.target.value)}
              required
              isInvalid={formInvalid}
              value={
              matchingSavedFilter
                ? `Mentett szűrő: ${matchingSavedFilter.filterName}`
                : filterName
            }
              disabled={!!matchingSavedFilter}
            />
            <Form.Control.Feedback type="invalid">
              A mező kitöltése kötelező!
            </Form.Control.Feedback>
          </Form.Group>
        </Col>
        <Col md={2} className="filter-list-button">
          <Button
            className="float-right"
            variant="primary"
            id="button-save-layout"
            onClick={handleClick}
            disabled={!!matchingSavedFilter}
            size="sm"
          >
            Mentés
          </Button>
        </Col>
      </Row>
    </Container>
  );
};

export default SaveLayout;
