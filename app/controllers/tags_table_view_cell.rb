class TagsTableViewCell < UITableViewCell
  def layoutSubviews
    super
    # self.imageView.frame = [[0,0],[40,40]]
    desiredWidth = 32;
    imageViewWidth = self.imageView.frame.size.width
    if imageViewWidth > desiredWidth
      widthDifference = imageViewWidth - desiredWidth
      self.imageView.frame =
      [[self.imageView.frame.origin.x+5,self.imageView.frame.origin.y],
      [desiredWidth,self.imageView.frame.size.height]]
      self.textLabel.frame =
      [[self.textLabel.frame.origin.x-widthDifference,self.textLabel.frame.origin.y],
      [self.textLabel.frame.size.width+widthDifference,self.textLabel.frame.size.height]]
      self.imageView.contentMode = UIViewContentModeScaleAspectFit
    end
  end
end