class Sprites::SpriteStylesheet
  INDENT                 = '  '
  INVALID_CSS_NAME_CHARS = /\W/

  def initialize(image_grid)
    @image_grid = image_grid
  end

  def to_s
    style = ''

    rule_blocks.each do |block|
      style << "\n" unless rule_blocks[0] == block
      style << "#{ block[:selector] } {\n"
      style << "#{ declarations_to_s(block[:declarations]) }"
      style << "}\n"
    end

    style
  end

  private

  def rule_blocks
    rules = [
      {
        selector: ".#{ base_class }",
        declarations: base_declarations
      }
    ]

    @image_grid.each_with_index do |image, row, column|
      rules << {
        selector: ".#{ base_class }.#{ image_class(row, column) }",
        declarations: declarations_for_image(image, row, column)
      }
    end

    rules
  end

  def declarations_to_s(declarations)
    declarations_to_s = ''

    declarations.each do |declaration|
      declarations_to_s << "#{ INDENT }#{ declaration[:property] }: #{ declaration[:value] };\n"
    end

    declarations_to_s
  end

  def base_class
    @image_grid.name.gsub(INVALID_CSS_NAME_CHARS, '-')
  end

  def image_class(row, column)
    "#{ base_class }-#{ @image_grid.image_name(row, column).gsub(INVALID_CSS_NAME_CHARS, '-') }"
  end

  def base_declarations
    [
      {
        property: 'display',
        value: 'inline-block'
      },
      {
        property: 'background',
        value: "url('#{ base_class }.png') no-repeat"
      }
    ]
  end

  def declarations_for_image(image, row, column)
    [
      {
        property: 'width',
        value: "#{ with_px(image.columns) }"
      },
      {
        property: 'height',
        value: "#{ with_px(image.rows) }"
      },
      {
        property: 'background-position',
        value: "#{ with_px(-1 * @image_grid.image_x_offset(row, column)) } #{ with_px(-1 * @image_grid.image_y_offset(row)) }"
      },
    ]
  end

  def with_px(value)
    unit = 'px' unless value == 0
    "#{ value }#{ unit }"
  end
end
