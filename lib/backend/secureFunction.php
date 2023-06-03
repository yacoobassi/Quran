<?php
function filter($request){
   return htmlspecialchars(strip_tags($_POST[$request]));
}