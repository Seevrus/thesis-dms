import { Card, Col, Row } from 'react-bootstrap';
import ChartistGraph from 'react-chartist';

const AvgDeliveryTime = () => {
  const data = {
    labels: ['1 hét', '1 hónap', '>1 hónap'],
    series: [20, 50, 30],
  };

  const options = {
    labelInterpolationFnc(label: string) {
      return label;
    },
    height: '100%',
  };

  const responsiveOptions = [
    ['screen and (min-width: 640px)', {
      // chartPadding: 30,
      // labelOffset: 100,
      // labelDirection: 'explode',
      height: '110%',
    }],
    ['screen and (min-width: 1024px)', {
      // labelOffset: 80,
      // chartPadding: 20,
      height: '120%',
    }],
  ];

  return (
    <Card>
      <Card.Header>
        <Card.Title as="h4">Átlagos kézbesítési idő</Card.Title>
      </Card.Header>
      <Card.Body>
        <Row>
          <Col md="6">
            <ChartistGraph
              data={data}
              type="Pie"
              options={options}
              responsiveOptions={responsiveOptions}
            />
          </Col>
          <Col md="6">
            <ChartistGraph
              data={data}
              type="Pie"
              options={options}
              responsiveOptions={responsiveOptions}
            />
          </Col>
        </Row>
      </Card.Body>
    </Card>
  );
};

export default AvgDeliveryTime;
