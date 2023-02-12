import { DataSource,DataSourceOptions } from 'typeorm';
import {User} from '../entities/User'
import {Post} from '../entities/Post'
//import Main from '../Main' 


export const AppDataSource = new DataSource({
    type: "postgres",
    host: "localhost",
    port: 5432,
    username: "mm-matrix-bridge",
    password: "hunter2",
    database: "mm-matrix-bridge",
    synchronize: false,
    logging: "all",
    logger:"advanced-console",
    entities: [Post, User],
    subscribers: [],
    migrations: [],
  })

 
  
  export async function run():Promise<any> {
      try {
          let ds=await AppDataSource.initialize()
          console.info (ds) 
          let n = await User.count()
          console.log("Count users",n)
          let u=await User.findOne({
              "where":{"is_matrix_user":true}
          })
          console.log (u)
          /*
          let user = new User()
          user.access_token="x"
          user.is_matrix_user=false
          user.matrix_displayname="y"
          user.matrix_displayname="kalle"
          user.matrix_userid='xx'
          user.mattermost_userid='122'
          user.mattermost_username='Nils'
          user.save({"transaction":false})
          */
          return u
         
            
      } 
      catch (err) {
          console.error(err)
          throw err
      }
  }

  run()


