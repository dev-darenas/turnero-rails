## Created ConsultingRoom
ConsultingRoom.destroy_all

10.times.each_with_index do |item, index|
  ConsultingRoom.create(name: "Consultorio #{index}")
end
