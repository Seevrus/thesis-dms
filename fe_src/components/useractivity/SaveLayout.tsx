import { useState } from 'react';
import { Button, FormControl, InputGroup } from 'react-bootstrap';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { getMatchingSavedFilter, saveFilter, selectActiveFilter } from '../../store/activityFilterSlice';

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
    <InputGroup className="mb-3 filter-list" hasValidation>
      <FormControl
        placeholder="Nézet mentése..."
        aria-label="Nézet mentése..."
        aria-describedby="basic-save-layout"
        onChange={(e: React.ChangeEvent<HTMLInputElement>) => setFilterName(e.target.value)}
        required
        isInvalid={formInvalid}
        value={matchingSavedFilter ? `Mentett szűrő: ${matchingSavedFilter.filterName}` : ''}
        disabled={!!matchingSavedFilter}
      />
      <Button
        variant="outline-primary"
        id="button-save-layout"
        onClick={handleClick}
        disabled={!!matchingSavedFilter}
      >
        Mentés
      </Button>
      <FormControl.Feedback type="invalid">A mező kitöltése kötelező!</FormControl.Feedback>
    </InputGroup>
  );
};

export default SaveLayout;
