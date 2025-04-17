package com.test.Urban_Village.reservation.dto;

import java.sql.Date;

public class PayDTO {
private String reservation_id; 
private String id;
private String accommodation_id;
private Date checkin_date;
private Date checkout_date;
private int guest_count;
private double total_price;

public String getAccommodation_name() {
	return accommodation_name;
}
public void setAccommodation_name(String accommodation_name) {
	this.accommodation_name = accommodation_name;
}
private String accommodation_name;

public String getReservation_id() {
	return reservation_id;
}
public void setReservation_id(String reservation_id) {
	this.reservation_id = reservation_id;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getAccommodation_id() {
	return accommodation_id;
}
public void setAccommodation_id(String accommodation_id) {
	this.accommodation_id = accommodation_id;
}
public Date getCheckin_date() {
	return checkin_date;
}
public void setCheckin_date(Date checkin_date) {
	this.checkin_date = checkin_date;
}
public Date getCheckout_date() {
	return checkout_date;
}
public void setCheckout_date(Date checkout_date) {
	this.checkout_date = checkout_date;
}
public int getGuest_count() {
	return guest_count;
}
public void setGuest_count(int guest_count) {
	this.guest_count = guest_count;
}
public double getTotal_price() {
	return total_price;
}
public void setTotal_price(double total_price) {
	this.total_price = total_price;
}

}