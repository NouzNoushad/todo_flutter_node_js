const express = require('express');
const router = express.Router();

const Todo = require('./../models/Todo');

	router.get('/list', async function (req, res){
		var todo = await Todo.find();
		res.json(todo);
	});
	
	router.post('/add', async function (req, res) {
		await Todo.deleteOne({
			id: req.body.id
		});

		var newTodo = new Todo({
			id: req.body.id,
			userId: req.body.userId,
			title: req.body.title,
			content: req.body.content,
		});
		await newTodo.save();
		const response = { message: 'new todo created' + `id: ${req.body.id}` };
		res.json(response);
	});

	router.post('/delete', async function (req, res) {
		await Todo.deleteOne({
			id: req.body.id,
		});
		const response = { message: 'Todo deleted' + `id: ${req.body.id}` };
		res.json(response);
	})

module.exports = router;