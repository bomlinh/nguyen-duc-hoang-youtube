import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class PrismaService extends PrismaClient {
  constructor(configService: ConfigService) {
    super({
      datasources: {
        db: {
          url: configService.get('DATABASE_URL'),
        },
      },
    });
    // console.log('configService: ' + JSON.stringify(configService));
    // console.log('DB_URL: ' + JSON.stringify(configService.get('DATABASE_URL')));
  }
  cleanDatabase() {
    // In a 1 - N relation, delete N firstly, then delete "1"
    console.log('cleanDatabase');
    return this.$transaction([
      // 2 commands in ONE transaction (completed only ALL both commands completed
      this.note.deleteMany(),
      this.user.deleteMany(),
    ]);
  }
}
