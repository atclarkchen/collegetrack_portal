describe("Filtering", function() {
	beforeEach(function() { 
		loadFixtures('email_filter.html');
		$(EmailFilter.setup);
		spyOn(EmailFilter, 'slideOpen').and.callThrough();
		$('#change_filter').trigger('click');
	});
	describe('sliding open', function() {
		it('should be visible', function() {
			expect($('#accordian')).toBeVisible();
		});
	});
	describe('sliding submenu open', function() {
		beforeEach(function() {
			var category;
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
			var category;
			$('#accordian').find('h3').each(function() {
				if ($(this).text() == 'Race') {
					category = $(this);
					$(this).click();
					return false;
				}
			});
			var race;
			category.find('a').each(function() {
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
			var category;
			$('#accordian').find('h3').each(function() {
				if ($(this).text() == 'Race') {
					category = $(this);
					$(this).click();
					return false;
				}
			});
			var race;
			category.find('a').each(function() {
				if ($(this).text() == 'Asian') {
					race = $(this);
					$(this).click();
					return false;
				}
			});
			$('#save_filter').trigger('click');
		});
		it('should empty the pre existing filter', function() {
			expect($('#filters').empty()).toHaveBeenCalled();	
		});
		it('should populate the filter with Asian', function() {
			expect($('#filters')).toContainText('Asian');
		});
		it('should close the submenus', function() {
			category.find('a').each(function() {
				expect($(this)).toBeHidden();
			});
		});
		it('should close the filtering menu', function() {
			expect($('#accordian')).toBeHidden();
		});
	});
	describe('saving multiple filters', function() {
		beforeEach(function () {
			var category;
			$('#accordian').find('h3').each(function() {
				if ($(this).text() == 'Race') {
					category = $(this);
					$(this).click();
					return false;
				}
			});
			category.find('a').each(function() {
				if ($(this).text() == 'Asian' || $(this).text() == 'Black') {
					$(this).click();
					return false;
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
			var category;
			$('#accordian').find('h3').each(function() {
				if ($(this).text() == 'Race') {
					category = $(this);
					$(this).click();
					return false;
				}
			});
			var race;
			category.find('a').each(function() {
				if ($(this).text() == 'Asian') {
					race = $(this);
					$(this).click();
					return false;
				}
			});
			$('#save_filter').trigger('click');
			$('#filters').find('.leftFil').each(function() {
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
