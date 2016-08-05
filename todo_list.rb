class TodoList
  attr_accessor :title

  def initialize(title = 'To Do')
    @title = title
    @todos = []
  end

  def <<(todo)
    unless todo.instance_of? Todo
        raise TypeError, "Can only add Todo objects"
    end

    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.length
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    @todos[index].done! if item_at(index)
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  def mark_undone_at(index)
    @todos[index].undone! if item_at(index)
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete_at(index) if item_at(index)
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def each
    @todos.each { |todo| yield(todo) }

    self
  end

  def to_a
    @todos
  end

  def select
    list = TodoList.new(title)

    each do |todo|
      list.add(todo) if yield(todo)
    end

    list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def done?
    all_done.size == self.size
  end
end

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '
  attr_accessor :title, :done

  def initialize(title)
    @title = title
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end
