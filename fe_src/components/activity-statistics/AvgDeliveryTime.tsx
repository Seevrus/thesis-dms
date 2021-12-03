import { Card, Col, Row } from 'react-bootstrap';
import ChartistGraph from 'react-chartist';

const AvgDeliveryTime = () => {
  const data = {
    labels: ['1 hét', '1 hó', '>1 hó'],
    series: [20, 50, 30],
  };

  const options = {
    labelInterpolationFnc(label: string) {
      return label;
    },
    chartPadding: 0,
    height: '220px',
    width: '220px',
  };

  const responsiveOptions = [
    ['screen and (min-width: 500px)', {
      height: '270px',
      width: '270px',
    }],
    ['screen and (min-width: 770px)', {
      height: '300px',
      width: '300px',
    }],
    ['screen and (min-width: 1200px)', {
      height: '400px',
      width: '400px',
    }],
  ];

  return (
    <Card>
      <Card.Header>
        <Card.Title as="h4">Átlagos kézbesítési idő</Card.Title>
      </Card.Header>
      <Card.Body>
        <Row>
          <Col xs md="6" className="text-center">
            <div><h4>Bérjegyzék</h4></div>
            <ChartistGraph
              data={data}
              type="Pie"
              options={options}
              responsiveOptions={responsiveOptions}
            />
          </Col>
          <Col xs md="6" className="text-center">
            <div><h4>Tájékoztató</h4></div>
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
