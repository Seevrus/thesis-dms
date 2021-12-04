import { BaseResponseT } from '../commonTypes';
import { ActivityRequestT } from '../userActivity/userActivitySliceTypes';

export interface ActivityFilterT extends ActivityRequestT {}

export interface RawFilterT {
  id: number,
  filterName: string,
  activityFilter: string,
}

export interface SavedFilterT {
  id: number,
  filterName: string,
  activityFilter: ActivityFilterT,
}

export interface ActivityFilterSliceT {
  activeFilter: ActivityFilterT,
  savedFilters: SavedFilterT[],
}

export interface ActivityFilterResponseT extends BaseResponseT {
  filters: RawFilterT[]
}

export interface SaveFilterRequestT {
  filterName: string,
  filter: ActivityFilterT,
}
