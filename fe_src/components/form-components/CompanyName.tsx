import { useEffect } from 'react';
import { Col, Form, Row } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { fetchCompanies, selectCompanies } from '../../store/otherUsers/otherUsersSlice';

interface CompanyNameProps {
  disabled?: boolean;
  companyName: string;
  setCompanyName?: React.Dispatch<React.SetStateAction<string>>;
}

const CompanyName = ({
  disabled = true,
  companyName,
  setCompanyName,
}: CompanyNameProps) => {
  const dispatch = useAppDispatch();
  const companies = useAppSelector(selectCompanies);

  useEffect(() => {
    if (!disabled) {
      dispatch(fetchCompanies());
    }
  }, [disabled, dispatch]);

  const onCompanyChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    setCompanyName(e.target.value);
  };

  return (
    <Row>
      <Col className="md-12">
        <Form.Group controlId={`companyName-${uuidv4()}`}>
          <Form.Label>Cég</Form.Label>
          {disabled && (
          <Form.Control
            disabled
            value={companyName}
          />
          )}
          {!disabled && (
          <Form.Control
            as="select"
            default={companyName}
            onChange={onCompanyChange}
          >
            {companies.map((company) => (
              <option
                key={company.id}
                value={company.companyName}
              >
                {company.companyName}
              </option>
            ))}
          </Form.Control>
          )}
        </Form.Group>
      </Col>
    </Row>
  );
};

export default CompanyName;
