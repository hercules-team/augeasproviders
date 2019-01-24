# frozen_string_literal: true

shared_examples_for 'mailalias resource' do
  it { is_expected.to have_mailalias_resource_count(1) }

  it do
    is_expected.to contain_mailalias('foo').only_with('name' => 'foo',
                                                      'ensure'    => 'present',
                                                      'recipient' => 'bar',
                                                      'provider'  => 'augeas')
  end
end

shared_context 'mailalias' do
  it { is_expected.to have_mailalias_resource_count(0) }

  let :example_params do
    { 'foo' => { 'recipient' => 'bar' } }
  end

  context 'when mailalias_hash is a Hash' do
    let(:params) { { mailalias_hash: example_params } }
    let(:facts) { {} }

    include_examples 'mailalias resource'
  end

  context 'when ::augeasproviders_mailalias_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_mailalias_hash: example_params } }

    include_examples 'mailalias resource'
  end
end
