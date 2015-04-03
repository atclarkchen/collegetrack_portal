describe("Filtering", function() {
  var category;
  var race;
  beforeEach(function() { 
    loadFixtures('email_filter.html');
    $(EmailFilter.setup);
    $(Filter.setup);
    $('#change_filter').trigger('click');
  });
  describe('sliding open', function() {
    it('should be visible', function() {
      expect($('#accordian')).toBeVisible();
    });
  });
  describe('sliding submenu open', function() {
    beforeEach(function() {
      $('#accordian').find('h3').each(function() {
        if ($(this).text() == 'Race') {
          category = $(this);
          $(this).click();
          return false;
        }
      });
    });
    it('should show Asian, Black, and White', function() {
      category.find('a').each(function() {
        expect($(this)).toBeVisible();
      });
    });
  });
  describe('selecting filtering options', function() {
    beforeEach(function() {
      $('#accordian').find('h3').each(function() {
        if ($(this).text() == 'Race') {
          category = $(this);
          $(this).click();
          return false;
        }
      });
      category.next().find('a').each(function() {
        if ($(this).text() == 'Asian') {
          race = $(this);
          $(this).click();
          return false;
        }
      });
    });
    it('should be selected for option Asian', function() {
      expect(race).toHaveClass('selected');
    });
  });
  describe('saving a single filter', function() {
    beforeEach(function () {
      $('#accordian').find('h3').each(function() {
        if ($(this).text() == 'Race') {
          category = $(this);
          $(this).click();
          return false;
        }
      });
      category.next().find('a').each(function() {
        if ($(this).text() == 'Asian') {
          race = $(this);
          $(this).click();
          return false;
        }
      });
      $('#save_filter').trigger('click');
    });
    it('should populate the filter with Asian', function() {
      expect($('#filters')).toContainText('Asian');
    });
  });
  describe('saving multiple filters', function() {
    beforeEach(function () {
      $('#accordian').find('h3').each(function() {
        if ($(this).text() == 'Race') {
          category = $(this);
          $(this).click();
          return false;
        }
      });
      category.next().find('a').each(function() {
        if ($(this).text() == 'Asian' || $(this).text() == 'Black') {
          $(this).click();
        }
      });
      $('#save_filter').trigger('click');
    });
    it('should populate the filter with Asian and Black', function() {
      expect($('#filters')).toContainText('Asian');
      expect($('#filters')).toContainText('Black');
    });
  });
  describe('removing a single filter', function() {
    beforeEach(function () {
      $('#accordian').find('h3').each(function() {
        if ($(this).text() == 'Race') {
          category = $(this);
          $(this).click();
          return false;
        }
      });
      category.next().find('a').each(function() {
        if ($(this).text() == 'Asian') {
          race = $(this);
          $(this).click();
          return false;
        }
      });
      $('#save_filter').trigger('click');
      $('#filters').find('.left_fil').each(function() {
        if ($(this).text() == 'Asian') {
          $(this).next().click();
        }
      });
    });
    it('should remove the box', function() {
      expect('#filters').not.toHaveText('Asian');
    });
    it('should deselect Asian in the Race category', function() {
      expect(race).not.toHaveClass('selected');
    });
  });
});