import { zodResolver } from '@hookform/resolvers/zod';
import { date, z } from 'zod';

const GENDERS = ['mare', 'gelding', 'stallion'];

const makeObjectValidationSchema = ({ required }: { required: boolean }) => {
  const schema = z
    .object({
      value: z.string().nonempty('Wartość nie może być pusta'),
      label: z.string().nonempty('Etykieta nie może być pusta'),
    })
    .nullable()
    .refine((v) => v?.value !== '', { message: 'Musisz wybrać opcję' })
    .or(z.string().min(2, 'Imię musi mieć co najmniej 2 znaki'));

  return required ? schema : schema.optional();
};

export const step1Schema = z.object({
  name: z.string().min(2, 'Imię musi mieć co najmniej 2 znaki'),
  birthday: date(),
  place: z.string().min(2, 'Imię musi mieć co najmniej 2 znaki'),
  gender: z
    .string({ invalid_type_error: 'Zaznacz jedną z opcji' })
    .refine((val) => GENDERS.map((gender) => gender).includes(val)),
});

export const step2Schema = z.object({
  mother: makeObjectValidationSchema({ required: true }),
  motherGrandMother: makeObjectValidationSchema({ required: false }),
  motherGrandFather: makeObjectValidationSchema({ required: false }),
});

export const step3Schema = z.object({
  father: makeObjectValidationSchema({ required: true }),
  fatherGrandMother: makeObjectValidationSchema({ required: false }),
  fatherGrandFather: makeObjectValidationSchema({ required: false }),
});

export const switchResolver = (currentStepIndex: number) => {
  if (currentStepIndex === 0) return zodResolver(step1Schema);
  if (currentStepIndex === 1) return zodResolver(step2Schema);
  if (currentStepIndex === 2) return zodResolver(step3Schema);
};
