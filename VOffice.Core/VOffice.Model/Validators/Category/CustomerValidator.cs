using VOffice.Core.Validations;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VOffice.Model;
using System.Text.RegularExpressions;

namespace VOffice.Model.Validators
{
    public class CustomerValidator : AbstractValidator<Customer>
    {
        public CustomerValidator()
        {
            RuleFor(x => x.Code).NotEmpty().WithMessage("Mã khách hàng không để trống.");
            RuleFor(x => x.Title).NotEmpty().WithMessage("Tên khách hàng không để trống.");
            RuleFor(x => x.Order).GreaterThan(0).WithMessage("Thứ tự phải lớn hơn 0.");
            RuleFor(x => x.PhoneNumber).Length(10, 11).WithMessage("Độ dài số điện thoại chưa đúng.");
            RuleFor(x => x.CreatedOn).NotNull().WithMessage("Ngày tạo không được trống.");
            RuleFor(x => x.CreatedOn).SetValidator(new ValidSQLDateTimeValidator<DateTime>()).WithMessage("Ngày tạo không hợp lệ.");
            RuleFor(x => x.CreatedBy).NotEmpty().WithMessage("Chọn người tạo.");
            RuleFor(x => x.EditedOn).NotNull().WithMessage("Ngày sửa không được trống.");
            RuleFor(x => x.EditedOn).SetValidator(new ValidSQLDateTimeValidator<DateTime>()).WithMessage("Ngày sửa không hợp lệ.");
            RuleFor(x => x.EditedBy).NotEmpty().WithMessage("Chọn người sửa.");
        }
    }
}
