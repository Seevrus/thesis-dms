import { map } from 'ramda';
import { useEffect, useState } from 'react';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { OptionsT } from '../../interfaces/common';
import { fetchColumnOptions } from '../../store/activityFilter/activityFilterSlice';
import { createOption } from '../utils/helpers';

interface SimpleCompanyPropsT {
  setCompanyName: React.Dispatch<React.SetStateAction<string>>;
}

const SimpleCompany = ({ setCompanyName }: SimpleCompanyPropsT) => {
  const animatedComponents = makeAnimated();

  const [companyOptions, setCompanyOptions] = useState<OptionsT[]>();

  useEffect(() => {
    fetchColumnOptions('companyName')
      .then((fetchedOptions) => {
        setCompanyOptions(map(createOption, fetchedOptions));
      });
  }, []);

  const handleChange = (company) => {
    // eslint-disable-next-line @typescript-eslint/no-unused-expressions
    company ? setCompanyName(company.label) : setCompanyName(undefined);
  };

  return (
    <Select
      className="statistics-select"
      closeMenuOnSelect
      components={animatedComponents}
      isClearable
      isMulti={false}
      noOptionsMessage={() => 'Nincs több találat'}
      onChange={handleChange}
      options={companyOptions}
      placeholder="Cég kiválasztása..."
    />
  );
};

export default SimpleCompany;
