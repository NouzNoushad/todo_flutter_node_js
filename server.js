const express = require('express');
const app = express();
const mongoose = require('mongoose');

const Todo = require('./models/Todo');
const todoRouter = require('./routes/todo');

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const mongodbPath = 'mongodb+srv://nhd7noushadazeez:LEs6aJfjg7DZUxC7@cluster0.y7z5unj.mongodb.net/?		retryWrites=true&w=majority';
mongoose.connect(mongodbPath).then(() => {

	app.get('/', function (req, res) {
		res.json('Test API');
	});

	app.use('/todo', todoRouter);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
	console.log(`server started at PORT: ${PORT}`);
});