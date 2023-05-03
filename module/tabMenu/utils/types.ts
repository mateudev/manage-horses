import { TabSectionType } from '@/utils/types';
import { string } from 'zod';

export type TabsSectionEntity = TabSectionType[];

export type FormField = {
  name: string;
  placeholder: string;
  label: string;
};

export type FormFields = FormField[];
