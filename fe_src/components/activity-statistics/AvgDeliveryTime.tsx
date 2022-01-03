import {
  all,
  complement,
  isNil,
  reject,
  values,
} from 'ramda';
import { useEffect, useState } from 'react';
import { Card, Col, Row } from 'react-bootstrap';
import ChartistGraph from 'react-chartist';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { DeliveryT } from '../../store/statistics/statisticsSliceTypes';
import {
  fetchDeliveryStatistics,
  selectInfoLetterDeliveryStatistics,
  selectPayrollDeliveryStatistics,
} from '../../store/statistics/statisticsSlice';
import SimpleCompany from './SimpleCompany';

import './user-activity-diagram.scss';

const DELIVERY_LABELS = {
  '1 hét': 'lastWeek',
  '1 hónap': 'lastMonth',
  '> 1 hónap': 'moreThanOneMonth',
  'N/A': 'notDownloaded',
};

const AvgDeliveryTime = () => {
  const dispatch = useAppDispatch();

  const labels = [
    '1 hét',
    '1 hónap',
    '> 1 hónap',
    'N/A',
  ];

  const payrollDeliveryStatistics = useAppSelector(selectPayrollDeliveryStatistics);
  const infoLetterDeliveryStatistics = useAppSelector(selectInfoLetterDeliveryStatistics);
  const [infoLetterLabels, setInfoLetterLabels] = useState(labels);
  const [infoLetterSeries, setInfoLetterSeries] = useState<number[]>(new Array(4).fill(0));
  const [payrollLabels, setPayrollLabels] = useState(labels);
  const [payrollSeries, setPayrollSeries] = useState<number[]>(new Array(4).fill(0));
  const [companyName, setCompanyName] = useState<string>(undefined);

  const setData = (
    dataLabels: string[],
    setLabels: React.Dispatch<React.SetStateAction<string[]>>,
    statistics: DeliveryT,
    setSeries: React.Dispatch<React.SetStateAction<number[]>>,
  ) => {
    if (all(complement(isNil), values(statistics))) {
      setLabels(reject(
        (l: string) => statistics[DELIVERY_LABELS[l]] === 0,
        dataLabels,
      ));
      setSeries(reject(
        (v: number) => v === 0,
        [
          statistics[DELIVERY_LABELS['1 hét']],
          statistics[DELIVERY_LABELS['1 hónap']],
          statistics[DELIVERY_LABELS['> 1 hónap']],
          statistics[DELIVERY_LABELS['N/A']],
        ],
      ));
    }
  };

  const infoLetterData = {
    labels: infoLetterLabels,
    series: infoLetterSeries,
  };

  const payrollData = {
    labels: payrollLabels,
    series: payrollSeries,
  };

  useEffect(() => {
    dispatch(fetchDeliveryStatistics({ companyName }));
  }, [companyName, dispatch]);

  useEffect(() => {
    setData(
      labels,
      setPayrollLabels,
      payrollDeliveryStatistics,
      setPayrollSeries,
    );
  }, [payrollDeliveryStatistics]);

  useEffect(() => {
    setData(
      labels,
      setInfoLetterLabels,
      infoLetterDeliveryStatistics,
      setInfoLetterSeries,
    );
  }, [infoLetterDeliveryStatistics]);

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
      <Card.Header className="statistics-header">
        <Card.Title as="h4" className="statistics-title">
          Átlagos kézbesítési idő
        </Card.Title>
        <SimpleCompany setCompanyName={setCompanyName} />
      </Card.Header>
      <Card.Body>
        <Row>
          <Col xs md="6" className="text-center">
            <div><h4>Bérjegyzék</h4></div>
            <ChartistGraph
              data={payrollData}
              type="Pie"
              options={options}
              responsiveOptions={responsiveOptions}
            />
          </Col>
          <Col xs md="6" className="text-center">
            <div><h4>Tájékoztató</h4></div>
            <ChartistGraph
              data={infoLetterData}
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
