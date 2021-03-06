# frozen_string_literal: true

# Route class
class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station, insert_index)
    unless insert_index != 0 &&
           insert_index < (@stations.size - 1) &&
           insert_index != -1
      return
    end

    @stations.insert(insert_index, station)
  end

  def delete_station(station)
    unless @stations.index(station) != 0 &&
           @stations.index(station) != (@stations.size - 1)
      return
    end

    @stations.delete(station)
  end

  def display_stations
    puts 'Маршрут следования:'
    @stations.each { |station| puts station.name }
  end
end
