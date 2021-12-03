import { equals, findIndex } from 'ramda';
import { Card, Col, Row } from 'react-bootstrap';
import ChartistGraph from 'react-chartist';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import './user-activity-diagram.scss';

const animatedComponents = makeAnimated();

const UserActivityDiagram = () => {
  const data = {
    labels: [
      '1 hét',
      '2 hét',
      '1 hónap',
      '2 hónap',
      '3 hónap',
      '6 hónap',
      'több',
    ],
    series: [
      0.10,
      0.30,
      0.20,
      0.15,
      0.10,
      0.04,
      0.01,
    ],
  };

  const options = {
    distributeSeries: true,
    axisX: {
      labelInterpolationFnc(value: string) {
        return `${findIndex(equals(value), data.labels) + 1}.`;
      },
      showGrid: false,
    },
    axisY: {
      labelInterpolationFnc(value: number) {
        return `${(value * 100).toFixed(1)}%`;
      },
      offset: 60,
    },
    height: '245px',
  };

  const responsiveOptions = [
    [
      'screen and (min-width: 550px)',
      {
        axisX: {
          labelInterpolationFnc(value: string) {
            return value;
          },
        },
      },
    ],
  ];

  return (
    <Card>
      <Card.Header>
        <Card.Title as="h4">Felhasználói aktivitás</Card.Title>
      </Card.Header>
      <Card.Body>
        <Row>
          <Col lg="8">
            <ChartistGraph
              data={data}
              options={options}
              responsiveOptions={responsiveOptions}
              type="Bar"
              listener={{
                draw: (e) => e.type === 'bar' && e.element.attr({
                  style: 'stroke-width: 3vw',
                }),
              }}
            />
          </Col>
          <Col lg="4">
            <Row>
              <Select
                closeMenuOnSelect={false}
                components={animatedComponents}
                isClearable
                noOptionsMessage={() => 'Nincs több találat'}
                // onChange={handleChange}
                // options={optionsState}
                placeholder="Egyedi felhasználó..."
                // value={defaultOption}
              />
            </Row>
            <Row className="user-data-row">
              <p className="user-data">Utolsó belépés: 2021. 12. 03.</p>
              <p className="user-data">Eltelt idő: 42 nap</p>
            </Row>
          </Col>
        </Row>
      </Card.Body>
    </Card>
  );
};

export default UserActivityDiagram;
