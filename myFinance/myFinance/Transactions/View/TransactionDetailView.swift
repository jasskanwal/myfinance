//
//  TransactionDetailView.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

struct TransactionDetailView: View {
    let viewModel: TransactionDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isNoticeExpanded = false

	var body: some View {
		ZStack {
			AppColors.systemGroupedBackground.ignoresSafeArea(edges: .bottom)
			VStack(spacing: 0) {
				List {
					ForEach(Array(viewModel.sections.enumerated()), id: \.element.id) { index, section in
						Section {
							sectionContent(section)
						}
						.listSectionSeparator(.hidden)
					}
				}
				.listStyle(.inset)
				.scrollBounceBehavior(.basedOnSize)
				closeButton
			}
			.background(AppColors.listBackground)
			.clipShape(RoundedRectangle(cornerRadius: 14))
			.overlay {
				RoundedRectangle(cornerRadius: 14)
					.stroke(AppColors.seperator, lineWidth: 2)
			}
			.padding(16)
		}
		.navigationTitle(viewModel.navigationTitle)
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbarBackgroundVisibility(.visible, for: .navigationBar)
	}

    // MARK: - Section Router

    @ViewBuilder
    private func sectionContent(_ section: TransactionDetailViewModel.DetailSection) -> some View {
        switch section {
        case .header(let isCredit, let title):
            headerSection(isCredit: isCredit, title: title)
				.listRowSeparator(.hidden)
        case .transactionDetail(let rows):
            detailSection(rows: rows)
        case .notice:
            noticeSection
        }
    }

    // MARK: - Header Section

    private func headerSection(isCredit: Bool, title: String) -> some View {
        VStack(spacing: 14) {
            if isCredit {
                AppImages.successIcon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            } else {
                ZStack {
                    Circle()
                        .stroke(AppColors.primaryText, lineWidth: 2)
                        .frame(width: 60, height: 60)
                    Image(systemName: "arrow.up")
                        .font(AppFonts.headerIcon)
                        .foregroundStyle(AppColors.primaryText)
                }
            }
            Text(title)
                .font(AppFonts.detailTitle)
                .foregroundStyle(AppColors.primaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .accessibilityIdentifier("detail.header")
        .accessibilityLabel(title)
    }

    // MARK: - Transaction Detail Section

    private func detailSection(rows: [TransactionDetailViewModel.DetailRow]) -> some View {
            ForEach(Array(rows.enumerated()), id: \.offset) { index, row in
                VStack(alignment: .leading, spacing: 5) {
                    Text(row.label)
                        .font(AppFonts.detailLabel)
                        .foregroundStyle(AppColors.secondaryText)
                    HStack(spacing: 4) {
                        Text(row.value)
                            .font(AppFonts.detailValue)
                            .foregroundStyle(AppColors.primaryText)
                        if let secondary = row.secondaryValue {
                            Text(secondary)
                                .font(AppFonts.detailValue)
                                .foregroundStyle(AppColors.secondaryText)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
				.listRowSeparator(index == rows.count - 1 ? .hidden : .visible)
				.listRowSpacing(8)
            }
    }

    // MARK: - Notice Section

    private var noticeSection: some View {
        HStack(alignment: .top, spacing: 12) {
            AppImages.buddyTipIcon
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundStyle(AppColors.secondaryText)
                .animation(.none, value: isNoticeExpanded)

            noticeText
                .font(AppFonts.detailValue)
                .fixedSize(horizontal: false, vertical: true)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isNoticeExpanded.toggle()
                    }
                }
                .accessibilityIdentifier("detail.noticeToggle")
        }
		.padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(AppColors.listBackground)
                .shadow(color: .black.opacity(0.2), radius: 6, x: 6, y: 6)
				.animation(.none, value: isNoticeExpanded)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(AppColors.seperator, lineWidth: 2)
                .animation(.none, value: isNoticeExpanded)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .listRowSeparator(.hidden)
	}

    private var noticeText: Text {
        let base   = Text(viewModel.noticeBaseText).foregroundStyle(AppColors.primaryText)
        let toggle = Text(isNoticeExpanded ? viewModel.noticeShowLessLabel : viewModel.noticeShowMoreLabel).foregroundStyle(AppColors.link).bold()
        if isNoticeExpanded {
            let expanded = Text(viewModel.noticeExpandedText).foregroundStyle(AppColors.primaryText)
            return Text("\(base)\(expanded)\(toggle)")
        }
        return Text("\(base)\(toggle)")
    }

    // MARK: - Close Button (List Footer)

    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Text(viewModel.closeButtonTitle)
                .font(AppFonts.closeButton)
                .foregroundStyle(AppColors.buttonForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
				.background(RoundedRectangle(cornerRadius: 8).fill(AppColors.accent))
				.padding(.horizontal, 24)
				.padding(.bottom, 16)
        }
        .accessibilityIdentifier("detail.closeButton")
    }
}
