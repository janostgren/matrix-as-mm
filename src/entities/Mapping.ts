import {
    BaseEntity,
    Entity,
    PrimaryColumn,
    Column,
    Unique,

   
} from 'typeorm';


@Entity('mapping')
@Unique(['matrix_room_id'])
export class Mapping extends BaseEntity {
    @PrimaryColumn('text',{ nullable: false })
    public mattermost_channel_id!: string;
    @Column('text', { nullable: false})
    public matrix_room_id!: string;
    @Column('boolean', { nullable: false,default:true})
    public is_private!: string;
    @Column('boolean', { nullable: false,default:true})
    public is_direct!: string;  
}