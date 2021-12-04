import { ActivityFilterT } from '../store/activityFilter/activityFilterSliceTypes';

export type FilterListProps = {
  canHide: boolean;
  columnName: keyof ActivityFilterT;
  setVisibility: React.Dispatch<React.SetStateAction<string>>;
  style: { [key: string]: string };
};
