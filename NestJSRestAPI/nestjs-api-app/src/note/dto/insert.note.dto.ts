// import { IsNotEmpty, IsOptional, IsString } from "class-validator"
//
// export class InsertNoteDTO {
//     @IsString()
//     @IsNotEmpty()
//     title: string
//
//     @IsString()
//     @IsNotEmpty()
//     description: string
//
//     @IsString()
//     @IsNotEmpty()
//     url: string
// }

import { IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class InsertNoteDTO {
    @IsString()
    @IsNotEmpty()
    title: string;

    @IsString()
    @IsOptional()
    description: string;

    @IsString()
    @IsNotEmpty()
    url: string;
}