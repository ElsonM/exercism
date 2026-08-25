// Create an appointment n days from now (or from provided date)
export function createAppointment(n, now = new Date()) {
  const appointment = new Date(now);
  appointment.setDate(appointment.getDate() + n);
  
  return appointment;
}

// Convert a Date object to ISO 8601 timestamp string
export function getAppointmentTimestamp(date) {
  return date.toISOString();
}

// Get appointment details from ISO 8601 timestamp
export function getAppointmentDetails(timestamp) {
  const date = new Date(timestamp);
  
  return {
    year: date.getFullYear(),
    month: date.getMonth(),
    date: date.getDate(),
    hour: date.getHours(),
    minute: date.getMinutes(),
  };
}

// Update an appointment with given options (year, month, date, hour, minute)
export function updateAppointment(timestamp, options = {}) {
  const date = new Date(timestamp);
  
  if (options.year !== undefined) date.setFullYear(options.year);
  if (options.month !== undefined) date.setMonth(options.month);
  if (options.date !== undefined) date.setDate(options.date);
  if (options.hour !== undefined) date.setHours(options.hour);
  if (options.minute !== undefined) date.setMinutes(options.minute);
  
  return getAppointmentDetails(date);
}

// Calculate time difference in seconds between two timestamps
export function timeBetween(timestamp1, timestamp2) {
  const diffMs = Math.abs(new Date(timestamp1) - new Date(timestamp2));
  
  return Math.round(diffMs / 1000);
}

// Check if an appointment is valid (in the future)
export function isValid(appointmentTimestamp, nowTimestamp) {
  return new Date(appointmentTimestamp) > new Date(nowTimestamp);
}