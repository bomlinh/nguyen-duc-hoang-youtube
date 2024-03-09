import { Injectable } from '@nestjs/common';
import { InsertNoteDTO, UpdateNoteDTO } from './dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class NoteService {
  constructor(private prismaService: PrismaService) {}
  async insertNote(userId: number, insertNoteDTO: InsertNoteDTO) {
    const note = await this.prismaService.note.create({
      data: {
        ...insertNoteDTO,
        userId,
      },
    });
    return note;
  }
  getNotes(userId: number) {
    const notes = this.prismaService.note.findMany({
      where: {
        userId,
      },
    });
    return notes;
  }
  getNoteById(noteId: number) {}
  updateNoteById(noteId: number, updateNoteDTO: UpdateNoteDTO) {}

  deleteNoteById(noteId: number) {}
}
