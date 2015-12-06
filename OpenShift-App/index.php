<html>
<body>

<form action="to_json.php" method="post">
<select type="text" name="type">
 <optgroup>
    <option value="getTA">Search Name</option>
    <option value="getClasses">Search Class</option>
    <option value="TAsClasses">TA's Classes</option>
    <option value="ClassTAs">Classes' TAs</option>
    <option value="getSessions">Sessions</option>
    <option value="addClass">Add Class</option>
    <option value="addTA">Add TA/LA</option>
    <option value="addSession">Add Session</option>
    <option value="delete">Delete</option>
  </optgroup>
</select>
<input type="text" name="phrase1"><br>
<input type="text" name="phrase2"><br>
<input type="text" name="phrase3"><br>
<input type="text" name="phrase4"><br>
<input type="text" name="phrase5"><br>
<input type="submit">
</form>

</body>
</html> 
