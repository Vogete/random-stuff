# Angular tutorials

- First [Angular tutorial](https://youtu.be/oa9cnWTpqP8) for beginners
  - Project can be found in the [ng5](ng5/) folder

Instal Angular CLI:

- Install Node.js with npm
- Open terminal
- Install Angular CLI: `npm install @angular/cli -g`
- Create a new project: `ng new angular-project` (where angular-project is the name of your project)
  - you can specify extra arguments, like: `ng new ng5 --style=scss --routing` (routing will be enabled by default, scss will be the style format)
- Running the web app: `ng serve`

Deploying the app:

- `ng build`
  - creates a "dist" folder
  - deploy to production: `ng build --prod` (minimizes and reduces files)
