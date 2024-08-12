#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MOHAMED'S SALON ~~~~~\n"
HAIRCUT_MENU(){
echo -e "\nWelcome to my salon! How can I help you?\n"
echo -e "1) cut\n2) trim\n3) style\n"
read SERVICE_ID_SELECTED
case $SERVICE_ID_SELECTED in
  1) CHOICE_NAME="cut" SERVICE;;
  2) CHOICE_NAME="trim" SERVICE;;
  3) CHOICE_NAME="style" SERVICE;;
  *) HAIRCUT_MENU "We don't have this service.";;
esac  

}
SERVICE() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo -e "\nWhat time would you like your $CHOICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $CHOICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
HAIRCUT_MENU