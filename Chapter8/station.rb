# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'train'

# Station class
class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    name = name.to_s

    raise 'Название станции не должно быть пустым' if name.empty?
    raise "Станция с именем #{name} уже есть" if @@stations.detect { |station| station.name == name}

    register_instance

    @name = name
    @trains = []
    @@stations.push(self)
  end

  def self.all
    @@stations
  end

  def self.each
    if block_given?
      @@stations.each { |station| yield station }
    else
      raise "Не передан блок в #{self}.each"
    end
  end

  def each_trains
    if block_given?
      trains.each { |train| yield train }
    else
      raise "Не передан блок в инстанс метод #{self.class}#each_trains"
    end
  end

  # Тут смысла в этом методе нет, т.к. нельзя создать
  # невалидный объект, и менять напрямую тоже ничего нельзя
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def take_train(train)
    raise ArgumentError, "Поезд должен быть классом Train, а не #{train.class}" unless train.is_a?(Train)

    @trains.push(train)
  end

  def send_train(train)
    raise ArgumentError, "Поезд должен быть классом Train, а не #{train.class}" unless train.is_a?(Train)

    @trains.delete(train)
  end

  def get_trains_by_type(type)
    raise ArgumentError, "Неверно передан тип поезда, доступные значения: #{Train::VALID_TRAIN_TYPES.keys}" unless Train::VALID_TRAIN_TYPES.include?(type)

    @trains.select { |train| train.type == type }
  end

  private

  def validate!
    # Оставлю метод на будущее
  end
end
