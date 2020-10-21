/*console.log("Reply Module........");*/

var replyService = (function() {

	function add(reply, callback) {
		fetch('/replies/new', {
			method: 'post',
			headers: {
				'Content-Type': 'application/json; charset=utf-8',
				'X-CSRF-TOKEN': getcsrf()
			},
			body: JSON.stringify(reply)
		}).then(response => response.text())
			.then(data => callback(data))
			.catch(err => { if (error) { error(err); } })
	}

	function getList(param, callback, error) {
		/*		console.log("Test Fetch API.......");*/
		var bno = param.bno;
		var page = param.page || 1;
		fetch("/replies/pages/" + bno + "/" + page + ".json")
			.then(response => response.json())
			.then(data => {
				//onsole.log(data); 
				callback(data.replyCount, data.list);
			})
			.catch(err => { if (error) { error(err); } })
	}

	function remove(rno, replyer, callback, error) {
		fetch('/replies/' + rno, {
			method: 'delete',
			headers: {
				'Content-Type': 'application/json; charset=utf-8',
				'X-CSRF-TOKEN': getcsrf()
			},
			body: JSON.stringify({ rno: rno, replyer: replyer })
		})
			.then(response => response.text())
			.then(data => callback(data))
			.catch(err => { if (error) { error(err); } })
	}

	function update(reply, callback, error) {
		fetch('/replies/' + reply.rno, {
			method: 'put',
			headers: {
				'Content-Type': 'application/json; charset=utf-8',
				'X-CSRF-TOKEN': getcsrf()
			},
			body: JSON.stringify(reply),
		})
			.then(response => response.text())
			.then(data => callback(data))
			.catch(err => { if (error) { error(err); } })
	}


	function get(rno, callback, error) {
		fetch('/replies/' + rno + ".json", {
			method: 'get'
		})
			.then(response => response.json())
			.then(data => callback(data))
			.catch(err => { if (error) error(err); })
	}

	function displayTime(timeValue) {

		var dateObj = new Date(timeValue);
		var today = new Date();
		var gap = today.getTime() - timeValue;
		/*console.log("Date Gap : " + gap);*/
		if (gap < (1000 * 60 * 60 * 24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
		}
	}

	return {
		add: add,
		getList: getList,
		remove: remove,
		update: update,
		get: get,
		displayTime: displayTime
	};
})();